# AdministrateBatchActions

This gem allows you to quickly embed a UI on resources' list page, by using the UI, you are able to do batch actions, such as batch deletion or batch approval etc.

The helper addes checkboxes and batch action button which allows you to integrate some customized actions in `administrate` way.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'administrate_batch_actions'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install administrate_batch_actions

## Usage

It introduces three helpers as below:
```
administrate_batch_actions_select_all
administrate_batch_actions_checkbox(resource.id)
administrate_batch_actions_button(batch_action_name, target_handling_path)
```

You need to create customized administrate's views, then enables UI and regarding functions by placing above helpers where you want.

After doing that, you need to add customized action named as `*_batch_action`, this gem will auto-generate routes for actions with that pattern. For instance, if I have an action like below:
```
    def delete_batch_action
      User.find(params[:batch_action_ids]).each(&:destroy)
      redirect_to :admin_users, notice: "Successfully deleted #{params[:batch_action_ids].size} users"
    end
```

The auto-generated route is like:
```
delete_batch_action_admin_users POST  /admin/users/delete_batch_action(.:format)  admin/users#delete_batch_action
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/administrate_batch_actions. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the AdministrateBatchActions project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/administrate_batch_actions/blob/master/CODE_OF_CONDUCT.md).
