local curl = require("cURL")

caldav = {} --class

  function caldav:init(setconfig)
    self.config = setconfig
  end
  
  function caldav:connect()

    post = [[
    <?xml version="1.0" encoding="utf-8" ?>
    <C:calendar-query xmlns:D="DAV:" xmlns:C="urn:ietf:params:xml:ns:caldav">
      <D:prop>
        <D:getetag/>
        <C:calendar-data>
          <C:comp name="VCALENDAR">
            <C:prop name="VERSION"/>
            <C:comp name="VEVENT">
              <C:prop name="SUMMARY"/>
              <C:prop name="UID"/>
              <C:prop name="DTSTART"/>
              <C:prop name="DTEND"/>
              <C:prop name="DURATION"/>
              <C:prop name="RRULE"/>
              <C:prop name="RDATE"/>
              <C:prop name="EXRULE"/>
              <C:prop name="EXDATE"/>
              <C:prop name="RECURRENCE-ID"/>
            </C:comp>
            <C:comp name="VTIMEZONE"/>
          </C:comp>
        </C:calendar-data>
      </D:prop>
      <C:filter>
        <C:comp-filter name="VCALENDAR">
          <C:comp-filter name="VEVENT">
            <C:time-range start="20141104T000000Z"
                            end="20141220T000000Z"/>
          </C:comp-filter>
        </C:comp-filter>
      </C:filter>
    </C:calendar-query>
    ]]

    curl.easy({
      url = self.config.url,
      [curl.OPT_VERBOSE] = true,
      [curl.OPT_CUSTOMREQUEST] = 'REPORT',
      [curl.OPT_HTTPAUTH] = curl.AUTH_BASIC,
      [curl.OPT_USERPWD] = self.config.username .. ':' .. self.config.password
    })
      :setopt_httpheader({
        "Depth: 1",
        "Content-Type: application/xml; charset=utf-8",
        "User-Agent: Lua CalDav v0.0.1;",
      })
      :setopt_postfields(post)
      :setopt_writefunction(io.stderr) -- use io.stderr:write()
      :perform()
      :close()
  end

return caldav
