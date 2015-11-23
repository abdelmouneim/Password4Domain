#!/usr/bin/lua

--[[
	This pure-Lua software generate complex password using a passphrase and a domain name.
	Author = "Abdelmouneim Hanine <sup3rnova.m0nster@gmail.com>"
	URL = https://github.com/abdelmouneim/Password4Domain
	LICENSE = {
	
		Copyright (c) 2015 Abdelmouneim Hanine <sup3rnova.m0nster@gmail.com>


		Permission is hereby granted, free of charge, to any person obtaining a copy
		of this software and associated documentation files (the "Software"), to deal
		in the Software without restriction, including without limitation the rights
		to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
		copies of the Software, and to permit persons to whom the Software is
		furnished to do so, subject to the following conditions:


		The above copyright notice and this permission notice shall be included in
		all copies or substantial portions of the Software.


		THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
		IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
		FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL THE
		AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
		LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
		OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
		THE SOFTWARE.	
	}	

]]

local sha1 = require "lib/sha1" 
local md5 = require "lib/md5"
	


function welcome () 

	local welcome = [[
    _____                                    _ _  _   _____                        _       
   |  __ \                                  | | || | |  __ \                      (_)      
   | |__) __ _ ___ _____      _____  _ __ __| | || |_| |  | | ___  _ __ ___   __ _ _ _ __  
   |  ___/ _` / __/ __\ \ /\ / / _ \| '__/ _` |__   _| |  | |/ _ \| '_ ` _ \ / _` | | '_ \ 
   | |  | (_| \__ \__ \\ V  V | (_) | | | (_| |  | | | |__| | (_) | | | | | | (_| | | | | |
   |_|   \__,_|___|___/ \_/\_/ \___/|_|  \__,_|  |_| |_____/ \___/|_| |_| |_|\__,_|_|_| |_|
                                                                                           
   ==========================================================================================
   Password4Domain V0.0.1(2015)
   Author : Hanine Abdelmouneim <sup3rnova.m0nster@gmail.com>
   https://github.com/abdelmouneim
   Thanks for using this program :) 
   ==========================================================================================
]]

print (welcome)

end
--------------------------------------------------------------------------------------------
-- Handle The Script Arguments
	function get_script_args( script_args )
		local args = {}
		for i,_ in ipairs( script_args ) do
			if ( i % 2 ~= 0 ) then 
				args[ script_args[ i ] ] = script_args[ i+1 ]
			end
		end
		return args
	end 

	function validate_script_args(args)
		local valide = true
		if ( args["-d"] == nil) then
			valide = false
			print ("Example: ./Password4Domain -d domain.com -p passphrase")
			return false
		end
		if ( args["-p"] == nil) then
			valide = false
			print ("Example: ./Password4Domain -d domain.com -p passphrase")
			return false
		end
		return valide
	end

--------------------------------------------------------------------------------------------
-- Hardened The Password 
-- 
	function remove_occurrence (str)
		local result = ""
		local lenght = string.len(str)
		for i = 1, lenght do
			local char = str:sub(i,i)
			if ( string.find( result, char ) == nil ) then 
				result = result .. char
			end
		end
		return result
	end
	function hardened_password( password, passphrase, domain )
		local pass = password
		local md5_as_hex = md5.sumhexa( domain.."."..passphrase )
		local special_char = {"@","%%","Z","!","H","*","{","}","(",")","-","_","'","K",";",",","?","G","µ","#"}
		local chars = remove_occurrence ( md5_as_hex )
		local chars_len = string.len(chars)
		for i = 1, chars_len do 
			char = chars:sub(i,i)
			pass = string.gsub(pass, char, special_char[ i ], 1)
		end
		return pass
	end

--------------------------------------------------------------------------------------------
-- Generate The Password	
	function generate_password(passphrase, domain)
		return sha1( passphrase.."@"..domain )
	end
	
--------------------------------------------------------------------------------------------
-- MAIN	
	welcome ()
	local args = get_script_args( arg )
	if ( validate_script_args(args) ) then
		local domain = args["-d"]
		local passphrase = args["-p"]
		local generated_password = generate_password(args["-p"], args["-d"])
		local hardened_pass = hardened_password( generated_password, args["-p"], args["-d"] )	
		print ("   generated password : " ..hardened_pass )	
		print("")
	end
-- END MAIN
