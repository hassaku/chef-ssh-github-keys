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

include_recipe 'ssh-keys'

if node[:ssh_github_keys]
  node[:ssh_github_keys].each do |node_user, github_users|
    next unless node_user && github_users

    github_users.each do |github_user|
      bash "add key of github user #{github_user} into authorized_keys of #{node_user}" do
        user node_user
        environment "HOME" => "/home/#{node_user}"
        keys = "~/.ssh/authorized_keys"
        code <<-EOS
        echo "# Public Keys of github user #{github_user}" >> #{keys}
        curl https://github.com/#{github_user}.keys >> #{keys}
        echo >> #{keys}
        EOS
      end
    end
  end
end
