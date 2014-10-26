#
# Cookbook Name:: ssh-github-keys
# Recipe:: default
#
# Copyright 2014, hassaku
#
# Permission is hereby granted, free of charge, to any person obtaining
# a copy of this software and associated documentation files (the
# "Software"), to deal in the Software without restriction, including
# without limitation the rights to use, copy, modify, merge, publish,
# distribute, sublicense, and/or sell copies of the Software, and to
# permit persons to whom the Software is furnished to do so, subject to
# the following conditions:
#
# The above copyright notice and this permission notice shall be
# included in all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
# EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
# MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
# NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
# LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
# OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
# WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

if node[:ssh_github_keys]
  node[:ssh_github_keys].each do |node_user, github_users|
    next unless node_user && github_users

    template "#{node_user}'s authorized_keys" do
      path "/home/#{node_user}/update_authorized_keys.sh"
      owner node_user
      group node_user
      mode  0700
      source "update_authorized_keys.sh.erb"
      variables(github_users: github_users)
    end

    cron "update authorized_keys" do
      user node_user
      command "/bin/sh /home/#{node_user}/update_authorized_keys.sh"
      minute "0,15,30,45"
    end
  end
end
