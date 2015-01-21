# Encoding: utf-8
#
# Cookbook Name:: steamcmd
# Recipe:: arma3
#
# Copyright 2014, Marcin Sawicki
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
include_recipe 'multiarch::default'
include_recipe 'curl::default'
include_recipe 'curl::libcurl'
include_recipe 'steamcmd::default'

app_name = 'arma3server'

steamcmd_app app_name do
  app_id 233780
  app_name app_name
  app_game 'arma3server'
  hostname 'myaram3server'
  cfg_file 'cstrike/cfg/config_default.cfg'
  needAuth TRUE
end
