<?php
/******************************************************************************
  ___
 | _ \_  _ _ _ ___
 |  _/ || | '_/ _ \
 |_|  \_, |_| \___/
      |__/
   Game Library™

 Copyright © 2024-present tinyBigGAMES™ LLC
 All Rights Reserved.

 https://github.com/tinyBigGAMES/Pyro
 
-------------------------------------------------------------------------------
Based on:
  https://github.com/telecube/mysql-api
  
******************************************************************************/

// ensure this definition exists before running the script.
if(!defined('MAIN_INCLUDED'))
	exit("Not allowed here!");

// the master db for write/read
$master_db_host = "localhost";
$master_db_port = "3306";
$master_db_user = "";
$master_db_pass = "";

// set strong keys here - a good key generator can be found at: https://www.grc.com/passwords.htm
$apikey         = "";
