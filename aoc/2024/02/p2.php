<?php
5y
$file = file_get_contents("p1input.txt");
$input = explode("\n", $file);
$spacer = 5;
$safe = 0;
$fully_safe = 0;

function is_safe($line) {
    $string_nummers = explode(" ", $line);
    $nummers = array();
    foreach ($string_nummers as $nummer) {
        array_push($nummers, intval($nummer));
    }
    $is_increasing = false;
    $eerste_nummer = $nummers['0'];
    $tweede_nummer = $nummers['1'];

    $verschil = $eerste_nummer - $tweede_nummer;

    if ($verschil > 0){
        $is_increasing = false;
    } else {
        $is_increasing = true;
    }

    $safe = false;

    if ($is_increasing) {
        $prev = 0;
        $unsafe = false;
        for ($i = 0; $i < count($nummers); $i++) {
            if ($unsafe) {
                continue;
            }
            if ($i == 0){
                $prev = $nummers['0'];
                continue;
            }
            $inc = false;
            $diff = $prev - $nummers["$i"];
            if ($diff > 0) {$unsafe = true; continue;}
            $diff = abs($diff);
            if ($diff < 1 || $diff > 3) {$unsafe = true; continue;}
            if ($i == (count($nummers)-1)) {$safe = true;}
            $diff = 0;
            $prev = $nummers["$i"];
        }
        $unsafe = false;
    } else {
        $prev = 0;
        $unsafe = false;
        for ($i = 0; $i < count($nummers); $i++) {
            if ($unsafe) {
                continue;
            }
            if ($i == 0){
                $prev = $nummers['0'];
                continue;
            }

            $inc = false;
            $diff = $prev - $nummers["$i"];

            if ($diff < 0) {$unsafe = true; continue;}

            $diff = abs($diff);


            if ($diff < 1 || $diff > 3) {$unsafe = true; continue;}

            if ($i == (count($nummers)-1)) {$safe = true;}
            $diff = 0;
            $prev = $nummers["$i"];
        }
        $unsafe = false;
    }
    // if ($safe) { echo "safe\n"; }
    // else { echo "not safe\n"; }
    return $safe;
}
$safe_counter = 0;
foreach ($input as $line) {
    $safe = is_safe($line);
    if ($safe) {$safe_counter += 1;}
}
echo "aantal safe: $safe_counter\n";
?>
