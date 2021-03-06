=begin
 list_cloudforms_userids.rb

 Author: Kevin Morey <kevin@redhat.com>

 Description: This method lists CloudForms userids 
-------------------------------------------------------------------------------
   Copyright 2016 Kevin Morey <kevin@redhat.com>

   Licensed under the Apache License, Version 2.0 (the "License");
   you may not use this file except in compliance with the License.
   You may obtain a copy of the License at

       http://www.apache.org/licenses/LICENSE-2.0

   Unless required by applicable law or agreed to in writing, software
   distributed under the License is distributed on an "AS IS" BASIS,
   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
   See the License for the specific language governing permissions and
   limitations under the License.
-------------------------------------------------------------------------------
=end

dialog_hash = {}

users = $evm.vmdb(:user).all

users.each do |u|
  if u.id == $evm.root['user'].id
    dialog_hash[u.userid] = "(CURRENT) userid: #{u.userid}"
  else
    dialog_hash[u.userid] = "#{u.userid}"
  end
end

current = dialog_hash.detect {|k,v| v.include?('CURRENT') }
if current
  $evm.object['default_value'] = current[0]
else
  choose = {''=>'< choose a userid >'}
  dialog_hash = choose.merge!(dialog_hash)
end

$evm.object["values"]     = dialog_hash
$evm.log(:info, "$evm.object['values']: #{$evm.object['values'].inspect}")
