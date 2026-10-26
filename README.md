# AdministrateBatchActions

[![RSpec](https://github.com/SourceLabsLLC/administrate_batch_actions/actions/workflows/specs.yml/badge.svg)](https://github.com/SourceLabsLLC/administrate_batch_actions/actions/workflows/specs.yml)
[![Gem Version](https://badge.fury.io/rb/administrate_batch_actions.svg)](https://badge.fury.io/rb/administrate_batch_actions)

This plugin for [Administrate](https://github.com/thoughtbot/administrate) allows you to add batch/bulk actions to your Administrate resources index lists, such as batch deletion or batch approval, etc.

The available helpers add individual checkboxes, a 'select all' checkbox and batch action buttons which allow you to integrate custom batch/bulk actions.

## Demo

![Aug-21-2021 21-56-48](https://user-images.githubusercontent.com/541665/130339415-c69f4b53-e248-449a-8764-7a854c5b0dcb.gif)

## Requirements

- Ruby 3.2+
- Rails 7.1+
- Administrate 1.0+
- Propshaft or Sprockets. The script is added to Administrate's layout automatically with either asset pipeline.

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

Insert the helper between the 2 lines in [\_collection.html.erb](https://github.com/thoughtbot/administrate/blob/v1.0.0/app/views/administrate/application/_collection.html.erb#L23-L24)

```
<%= administrate_batch_actions_checkbox(resource.id) %> # individual row checkbox
```

Insert the helper between the 2 lines in [\_collection.html.erb](https://github.com/thoughtbot/administrate/blob/v1.0.0/app/views/administrate/application/_collection.html.erb#L74-L75)

```
<%=
  administrate_batch_actions_button(
    'Delete Selected',                    # button label (any string)
    admin_delete_batch_action_users_path, # route generated for your `*_batch_action` method
    { class: '', confirm: '' }
  )
%> # batch action submit button with optional `class` and `confirm` message params
```

The first argument is just the button's label: pass a string, not the name of the controller method.

Insert the helper between the 2 lines in [\_index.html.erb](https://github.com/thoughtbot/administrate/blob/v1.0.0/app/views/administrate/application/_index_header.html.erb#L38)

You need to create custom Administrate views and insert the helpers above.

Afterwards-- define your custom controller actions named as `*_batch_action` e.g.:

- `def delete_batch_action ;  ...; end`
- `def approve_batch_action; ...; end`
- etc

The gem will auto-generate route entries for controller actions that match this pattern. For instance-- if I have an action below:

```
def delete_batch_action
  User.find(params[:batch_action_ids]).each(&:destroy)
  redirect_to :admin_users, notice: "Successfully deleted #{params[:batch_action_ids].size} users"
end
```

The gem will auto-generate the following route:

```
admin_delete_batch_action_users POST  /admin/administrate_batch_actions/users/delete_batch_action(.:format)  admin/users#delete_batch_action
```

So you can call the method to display the button like so: `<%= administrate_batch_actions_button('Delete Selected', admin_delete_batch_action_users_path) %>`

Nested controllers are supported too: `Admin::Reports::UsersController` gets `admin_delete_batch_action_reports_users_path`.

### Custom namespace

By default the gem looks for controllers in `app/controllers/admin`. If your Administrate dashboards live under a different namespace, set it in `config/initializers/administrate_batch_actions.rb`:

```ruby
AdministrateBatchActions.namespace = :admin_panel
# or several namespaces
AdministrateBatchActions.namespace = [:admin, :backoffice]
```

Routes are prefixed with their namespace, e.g. `Backoffice::UsersController#delete_batch_action` gets `backoffice_delete_batch_action_users_path`.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `bundle exec rake spec` to run the tests. The system specs drive a headless Chrome through [Cuprite](https://github.com/rubycdp/cuprite), so Chrome needs to be installed. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

The tests run against the latest Rails by default. To test another version, set `RAILS_VERSION` (Rails 7.x uses Sprockets, Rails 8 uses Propshaft):

    $ rm -f Gemfile.lock
    $ RAILS_VERSION=7.2 bundle install
    $ RAILS_VERSION=7.2 bundle exec rake spec

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/SourceLabsLLC/administrate_batch_actions. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the AdministrateBatchActions project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/SourceLabsLLC/administrate_batch_actions/blob/master/CODE_OF_CONDUCT.md).
