#!/usr/bin/env php
<?php

// USAGE: declare -f | php alf_function_search.php 'search query'
// TODO: Convert this into a bash script?

$functionsBlob = stream_get_contents(STDIN);

preg_match_all('/^[^{]*.*(?:[\r\n][^}].*)*[\r\n]\}/m', $functionsBlob, $matches);

$functions = $matches[0];
$query = $argv[1];

$matchingFunctions = [];

foreach ($functions as $function) {
    if (strpos($function, $query) !== false) {
        $matchingFunctions[] = str_replace($query, "\e[0;31m{$query}\e[0m", $function);
    }
}

if ($matchingFunctions) {
    echo implode("\n", $matchingFunctions) . PHP_EOL;
}
