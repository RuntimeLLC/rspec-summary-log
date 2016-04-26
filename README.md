# rspec-summary-log
[![Gem Version](https://badge.fury.io/rb/rspec-summary-log.svg)](https://rubygems.org/gems/rspec-summary-log)

If you use gems like [parallel_tests](https://github.com/grosser/parallel_tests) you may need a full log of failed tests for ci.

Install
=======
```
gem install rspec-summary-log

# spec/spec_helper.rb
require 'rspec/summary_log'

# .rspec (or .rspec_parallel)
--require rails_helper
--format progress
--format RSpec::SummaryLog::FailedLogger --out tmp/failed.log
--format RSpec::SummaryLog::SummaryLogger --out tmp/summary.log
```

Loggers
=======
We have two kind of loggers:

#### RSpec::SummaryLog::FailedLogger

This logger writes file names of broken specs.

```
# tmp/failed.log

./spec/specifications/order_specification_spec.rb:14
./spec/specifications/order_specification_spec.rb:20
./spec/specifications/cart_specification_spec.rb:32
./spec/specifications/user_specification_spec.rb:67
./spec/specifications/admin_specification_spec.rb:73
```

For example you can rerun failed tests with `rspec $(cat tmp/failed.log)`.

#### RSpec::SummaryLog::SummaryLogger

This logger writes summary of broken specs.

```
# tmp/summary.log

  1) OrderSpecification#satisfied? should allow to order product
     Failure/Error: let(:product) { create(:product, row_type: row_type, rows_count: rows_count) }
     NoMethodError:
       undefined method `id' for nil:NilClass
     # ./spec/support/factories/user.rb:3:in `block (3 levels) in <top (required)>'
     # ./spec/support/factories/user.rb:3:in `block (3 levels) in <top (required)>'
     # /home/llxff/.rvm/gems/ruby-2.3.0@project/gems/factory_girl-4.5.0/lib/factory_girl/attribute/dynamic.rb:14:in `instance_exec'
     # /home/llxff/.rvm/gems/ruby-2.3.0@project/gems/factory_girl-4.5.0/lib/factory_girl/attribute/dynamic.rb:14:in `block in to_proc'

rspec ./spec/specifications/order_specification_spec.rb:14

  2) OrderSpecification#satisfied? should not allow to order product
     Failure/Error: let(:product) { create(:product, row_type: row_type, rows_count: rows_count) }
     NoMethodError:
       undefined method `id' for nil:NilClass
     # ./spec/support/factories/user.rb:3:in `block (3 levels) in <top (required)>'
     # /home/llxff/.rvm/gems/ruby-2.3.0@project/gems/factory_girl-4.5.0/lib/factory_girl/attribute/dynamic.rb:14:in `instance_exec'
     # /home/llxff/.rvm/gems/ruby-2.3.0@project/gems/factory_girl-4.5.0/lib/factory_girl/attribute/dynamic.rb:14:in `block in to_proc'
     # /home/llxff/.rvm/gems/ruby-2.3.0@project/gems/factory_girl-4.5.0/lib/factory_girl/evaluator.rb:71:in `instance_exec'

rspec ./spec/specifications/order_specification_spec.rb:20
```

**License: MIT**
