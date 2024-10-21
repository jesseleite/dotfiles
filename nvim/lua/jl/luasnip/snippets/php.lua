return {

  -- Open php
  s('php', fmt('<?php\n\n{}', { i(0) })),

  -- Class
  -- TODO: Add choice node to toggle between class, trait, and interface
  s('cl', fmt('<?php\n\nnamespace {};\n\nclass {}\n{{\n    {}\n}}', { i(1, 'App'), i(2, 'Name'), i(0) })),

  -- Class property
  -- TODO: Add choice node to toggle to static property
  s('prop', fmt('{} ${} = {};', { i(1, 'public'), i(2, 'name'), i(0, 'false') })),

  -- Class constant
  s('const', fmt('{} {} = {};', { i(1, 'const'), i(2, 'NAME'), i(0, "'numberwang'") })),

  -- TODO: Constructor / named constructor snippet(s)?

  -- Method
  s('met', fmt('{} function {}({}){}\n{{\n    {}\n}}', { i(1, 'public'), i(2, 'name'), i(3), i(4), i(0, '//') })),

  -- $this->
  s('t', t('$this->')),

  -- Closure function
  -- TODO: Add choice node to toggle between normal and normal+use
  s('func', fmt('function ({}) {{\n    {}\n}}', { i(1), i(0, '//') })),

  -- Shorthand arrow function
  s('fn', fmt('fn ({}) => {}', { i(1), i(0) })),

  -- Laravel route
  s('route', fmt("Route::{}('{}', {});", { i(1, 'get'), i(2, 'uri'), i(0, "[SomeClass::class, 'method']") })),

  -- Test method
  s('test', fmt('#[Test]\npublic function {}()\n{{\n    {}\n}}', { i(1, 'it_can_do_something'), i(0, '//') })),

  -- Test set up method
  s('setup', fmt('public function setUp(): void\n{{\n    parent::setUp();\n\n    {}\n}}', { i(0) })),

  -- Test tear down method
  s('tear', fmt('public function tearDown(): void\n{{\n    {}\n\n    parent::tearDown();\n}}', { i(0) })),

  -- Other misc phpunit test helpers
  s('weh', t('$this->withoutExceptionHandling();')),
  s('skip', t('$this->markTestSkipped();')),
  s('raysp', t('\\Spatie\\LaravelRay\\RayServiceProvider::class,')),

  -- TODO: How to automatically paste visual selection into this?
  s('raypass', fmt('ray()->pass({})', { i(0) })),

}
