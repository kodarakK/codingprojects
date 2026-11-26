<?php
$file  = file_get_contents("p1input.txt");
$pattern = "/(?<mul>mul\((\d{1,3}),(\d{1,3})\))|(?<do>do\(\))|(?<dont>don't\(\))/";

preg_match_all($pattern, $file, $matches, PREG_SET_ORDER);

$do = true;
$acc = 0;

foreach ($matches as $m) {

    if (!empty($m['do'])) {
        $do = true;

    } elseif (!empty($m['dont'])) {
        $do = false;

    } elseif (!empty($m['mul'])) {
        if ($do) {
            $acc += $m[2] * $m[3];
        }
    }
}
var_dump($acc);
?>
