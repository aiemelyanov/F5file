when HTTP_REQUEST {
  if {[HTTP::path] eq "/isitthef5"} {
        HTTP::url "http://www.isitthef5.com"
  }
}
