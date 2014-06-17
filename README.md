ssh-github-keys Cookbook
========================
This cookbook add public keys used in github into authorized_keys.

Requirements
------------
- `curl` - ssh-github-keys needs curl to get public keys from github.

Usage
-----
If you use Berkshelf, add this cookbook as follow.

```ruby
cookbook "ssh-github-keys", github: "hassaku/chef-ssh-github-keys"
```

Add `ssh-github-keys` recipe in your node's `run_list`
and attributes which has pair of username and github accounts.

Those public keys will be added into /home/`username`/.ssh/authorized_keys.

```json
{
  ...
  "ssh_github_keys": {
    "ec2-user": ["github_user_1", "github_user_2"]
  },
  "run_list": [
    ...
    "recipe[ssh-github-keys]"
    ...
  ],
  ...
}
```

The ssh-github-keys depends on [chef-ssh-keys](https://github.com/nickola/chef-ssh-keys "chef-ssh-keys").
Hence, you can add also public keys included in a data bag.

```json
{
  ...
  "ssh_keys": {
    "ec2-user": ["user_1", "user_2"]
  },
  ...
}
```

and data_bags/users/user_1.json

```json
{
  "id": "user_1",
  "ssh_keys": "ssh-rsa XXXXXX..."
}
```

Set false for "ssh_keys_keep_existing" to remove keys in existence before adding new keys.

```json
{
  ...
  "ssh_keys_keep_existing" : false,
  ...
}
```

Contributing
------------

1. Fork the repository on Github
2. Create a named feature branch (like `add_component_x`)
3. Write your change
4. Write tests for your change (if applicable)
5. Run the tests, ensuring they all pass
6. Submit a Pull Request using Github

License
-------------------

MIT
