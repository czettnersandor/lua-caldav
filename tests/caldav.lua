local LuaUnit = require('luaunit')
local caldav = require('caldav')

TestCaldav = {} --class
  function TestCaldav:testConnection()
    caldav:init({url = 'https://www.google.com/calendar/dav/johndoe@gmail.com/user', username = 'johndoe@gmail.com', password = '123456'})
    caldav:connect()
    assertEquals( type(result), 'number' )
    assertEquals( result, 3 )
  end
-- class TestMyStuff

LuaUnit:run()
