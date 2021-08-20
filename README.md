# AdministrateBatchActions

This plugin for [Administrate](https://github.com/thoughtbot/administrate) allows you to add batch/bulk actions to your Administrate resources index lists, such as batch deletion or batch approval, etc.

The available helpers add individual checkboxes, a 'select all' checkbox and batch action buttons which allow you to integrate custom batch/bulk actions.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'administrate_batch_actions'
```

And then execute:

    $ bundle

Or install it yourself:

    $ gem install administrate_batch_actions

## Usage

The gem introduces three helper methods below:
```
administrate_batch_actions_select_all() # renders Select All checkbox
```
```
administrate_batch_actions_checkbox(resource.id) # individual row checkbox
```
```
administrate_batch_actions_button(batch_action_name, target_handling_path) # batch action submit button
```

You need to create custom Administrate views and insert the helpers above.

Afterwards-- define your custom controller actions named as `*_batch_action` e.g.:
* `def delete_batch_action ;  ...; end`
* `def approve_batch_action; ...; end`
* etc

The gem will auto-generate route entries for controller actions matches to this pattern. For instance-- if I have an action below:

```
def delete_batch_action
  User.find(params[:batch_action_ids]).each(&:destroy)
  redirect_to :admin_users, notice: "Successfully deleted #{params[:batch_action_ids].size} users"
end
```

The gem will auto-generate the following route:
```
delete_batch_action_admin_users POST  /admin/users/delete_batch_action(.:format)  admin/users#delete_batch_action
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/SourceLabsLLC/administrate-batch-actions. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the AdministrateBatchActions project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/SourceLabsLLC/administrate-batch-actions/blob/master/CODE_OF_CONDUCT.md).
