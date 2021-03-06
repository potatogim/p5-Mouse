#!/usr/bin/env perl
# This is automatically generated by author/import-moose-test.pl.
# DO NOT EDIT THIS FILE. ANY CHANGES WILL BE LOST!!!
use t::lib::MooseCompat;
use strict;
use warnings;
use Test::More;
$TODO = q{Mouse is not yet completed};

do {
    package Role::Foo;
    use Mouse::Role;

    sub foo { }


    package Consumer::Basic;
    use Mouse;

    with 'Role::Foo';

    package Consumer::Excludes;
    use Mouse;

    with 'Role::Foo' => { -excludes => 'foo' };

    package Consumer::Aliases;
    use Mouse;

    with 'Role::Foo' => { -alias => { 'foo' => 'role_foo' } };

    package Consumer::Overrides;
    use Mouse;

    with 'Role::Foo';

    sub foo { }
};

my @basic     = Consumer::Basic->meta->role_applications;
my @excludes  = Consumer::Excludes->meta->role_applications;
my @aliases   = Consumer::Aliases->meta->role_applications;
my @overrides = Consumer::Overrides->meta->role_applications;

is(@basic,     1);
is(@excludes,  1);
is(@aliases,   1);
is(@overrides, 1);

my $basic     = $basic[0];
my $excludes  = $excludes[0];
my $aliases   = $aliases[0];
my $overrides = $overrides[0];

isa_ok($basic,     'Mouse::Meta::Role::Application');
isa_ok($excludes,  'Mouse::Meta::Role::Application');
isa_ok($aliases,   'Mouse::Meta::Role::Application');
isa_ok($overrides, 'Mouse::Meta::Role::Application');

is($basic->role,     Role::Foo->meta);
is($excludes->role,  Role::Foo->meta);
is($aliases->role,   Role::Foo->meta);
is($overrides->role, Role::Foo->meta);

is($basic->class,     Consumer::Basic->meta);
is($excludes->class,  Consumer::Excludes->meta);
is($aliases->class,   Consumer::Aliases->meta);
is($overrides->class, Consumer::Overrides->meta);

is_deeply($basic->get_method_aliases,     {});
is_deeply($excludes->get_method_aliases,  {});
is_deeply($aliases->get_method_aliases,   { foo => 'role_foo' });
is_deeply($overrides->get_method_aliases, {});

is_deeply($basic->get_method_exclusions,     []);
is_deeply($excludes->get_method_exclusions,  ['foo']);
is_deeply($aliases->get_method_exclusions,   []);
is_deeply($overrides->get_method_exclusions, []);

done_testing;
