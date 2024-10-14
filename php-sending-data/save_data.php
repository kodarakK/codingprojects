<?php
header("Content-Type: application/json; charset=UTF-8");
$json = $_GET["x"];
file_put_contents("~/codingprojects/php-sending-data/data.json", $json);
?>