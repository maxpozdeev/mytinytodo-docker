<?php

// Rename it to config.php before using in docker.

define("_MTT_DB_TYPE", getenv('MTT_DB_TYPE') ?: "");

if (_MTT_DB_TYPE == 'mysql' || _MTT_DB_TYPE == 'postgres') {
    define("MTT_DB_TYPE", _MTT_DB_TYPE);
    define("MTT_DB_HOST", getenv('MTT_DB_HOST') ?: "undefined_host");
    define("MTT_DB_NAME", getenv('MTT_DB_NAME') ?: "undefined_db");
    define("MTT_DB_USER", getenv('MTT_DB_USER') ?: "undefined_user");
    define("MTT_DB_PASSWORD", getenv('MTT_DB_PASSWORD') ?: "");
    define("MTT_DB_PREFIX", getenv('MTT_DB_PREFIX') ?: "mtt_");
    define("MTT_DB_DRIVER", getenv('MTT_DB_DRIVER') ?: "");
}
else if (_MTT_DB_TYPE == 'sqlite') {
    define("MTT_DB_TYPE", _MTT_DB_TYPE);
    define("MTT_DB_PREFIX", "");
}

define("MTT_SALT", "Put Random Text Here");
