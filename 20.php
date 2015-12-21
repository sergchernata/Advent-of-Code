<?php

    $i=1;
    $current = 10;
    $max = 29000000;

    while ($current <= $max)
    {
        $new = 0;

        for($k=1; $k<=$i; $k++)
        {
            if($i % $k == 0){ $new += $k * 10; }
        }

        $current = $new;
        $i++;
    }

    var_dump($current);
    var_dump($i);