## READ THIS 

- Actually there's almost no reason you should want this repo, because there's an actively developed one (by the people who actually initially wrote this at EY), here:

https://github.com/dylanegan/sappy                                 

# sappy

## Description:

A ruby library providing a wrapper around the SiteUptime API.

## Usage: 

    require 'rubygems'
    require 'sappy'
	require 'net/http'
	require 'net/https'


    @account = Sappy::Account.login('email@email.com', 'password')

    monitors = @account.monitors
    monitor = monitors.first
    monitor.disable

    monitor = @account.add_monitor(...)

## License:

(The MIT License)

Copyright (c) 2008-2009 Dylan Egan, Tim Carey-Smith

Permission is hereby granted, free of charge, to any person obtaining a copy of
this software and associated documentation files (the 'Software'), to deal in
the Software without restriction, including without limitation the rights to use,
copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the
Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED,
INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR
PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWAge, publish, distribute, sublicense, and/or sell
