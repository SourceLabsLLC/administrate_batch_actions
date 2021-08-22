# AdministrateBatchActions

This plugin for [Administrate](https://github.com/thoughtbot/administrate) allows you to add batch/bulk actions to your Administrate resources index lists, such as batch deletion or batch approval, etc.

The available helpers add individual checkboxes, a 'select all' checkbox and batch action buttons which allow you to integrate custom batch/bulk actions.

## Demo
![Aug-21-2021 21-56-48](https://user-images.githubusercontent.com/541665/130339415-c69f4b53-e248-449a-8764-7a854c5b0dcb.gif)

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
<%= administrate_batch_actions_select_all() %> # renders Select All checkbox
```
Insert the helper between the 2 lines in [_collection.html.erb](https://github.com/thoughtbot/administrate/blob/v0.16.0/app/views/administrate/application/_collection.html.erb#L23-L24)

```
<%= administrate_batch_actions_checkbox(resource.id) %> # individual row checkbox
```
Insert the helper between the 2 lines in [_collection.html.erb](https://github.com/thoughtbot/administrate/blob/v0.16.0/app/views/administrate/application/_collection.html.erb#L61-L62)

```
<%= administrate_batch_actions_button(batch_action_name, target_handling_path) %> # batch action submit button
```
Insert the helper between the 2 lines in [_index.html.erb](https://github.com/thoughtbot/administrate/blob/v0.16.0/app/views/administrate/application/index.html.erb#L34)

You need to create custom Administrate views and insert the helpers above.

Afterwards-- define your custom controller actions named as `*_batch_action` e.g.:
* `def delete_batch_action ;  ...; end`
* `def approve_batch_action; ...; end`
* etc

The gem will auto-generate route entries for controller actions that match this pattern. For instance-- if I have an action below:

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
So you can call the method to display the button like so: `<%= administrate_batch_actions_button('Delete Selected, delete_batch_action_admin_users_path)`

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/SourceLabsLLC/administrate_batch_actions. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the AdministrateBatchActions project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/SourceLabsLLC/administrate_batch_actions/blob/master/CODE_OF_CONDUCT.md).
