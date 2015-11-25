Password4Domain.lua
===================

This pure-Lua software generate complex password using a passphrase and a domain name. 

Description
===========

Instead of using different password for each account on the internet, this program will help
you to generate different password using the same passphrase for each domain. Thus you don't
have to worry about remembering a lot of password; only one is enough. But this password 
should be strong (the best practices dictate that a password should be at least 8 character long, 
and the password must contains special chars, numbers, lowercase and uppercase lettre) 
to prevent brute force attack.

Just keep in mind that every time you need to access your online account, you must use this program
to generate the password for that particular account; using the same passphrase that you already give 
and the domain name. 

The main idea behind this program is to take two strings (passphrase and domain name) and generate 
from them a complex password. therefore this utility can be used for professional purposes such as 
generating password for infrastructure devices (Router, switch ... ), instead of giving a domain name 
you can replace it by the device identifier. 

If you have any question or comment please contact me at <sup3rnova.m0nster@gmail.com>

Usage 
=====
This program is developped using Lua, so to take benifit from it, you should have Lua interpreter 
installed on your computer, if not you can download it from Lua.org/download.html

    cd path/to/where/the/program/folder/is
    ./Password4Domain -d facebook.com -p p455w0rd*
    -- The -d option stand for the domain name
    -- The -p option stand for the passphrase
	
Caution
=======

Using this program will make you vulnerable to shoulder surfing attack ( Oops :/ )
I'll fix it for the next version. 

Credits
=======

This program is developed by Abdelmouneim Hanine <sup3rnova.m0nster@gmail.com>

License
=======

This version, as well as all the dependencies in which is based, are implemented under the MIT license (See license file for details).
