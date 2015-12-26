<?php

    $grid = array(
        array(20151125, 18749137, 17289845, 30943339, 10071777, 33511524),
        array(31916031, 21629792, 16929656,  7726640, 15514188,  4041754),
        array(16080970,  8057251,  1601130,  7981243, 11661866, 16474243),
        array(24592653, 32451966, 21345942,  9380097, 10600672, 31527494),
           array(77061, 17552253, 28094349,  6899651,  9250759, 31663883),
        array(33071741,  6796745, 25397450, 24659492,  1534922, 27995004)
    );

    $row = 0;
    $col = 0;
    $target_row = 3010 - 1;// array is zero based
    $target_col = 3019 - 1;
    $max_row = 3019 * 2;// grid gets filled diagonally, so the value we need
    $max_col = 3019 * 2;// isn't present until grid is twice larger

    function formula($n){ return ($n * 252533) % 33554393; }

    while ($row <= $max_row && $col <= $max_col)
    {
        if(!isset($grid[$row][$col]))// skip existing values
        {
            if($col == 0)// find prev value for calculation
            {
                $prev_col = $row - 1;
                $prev_row = 0;
            }
            else
            {
                $prev_row = $row + 1;
                $prev_col = $col - 1;
            }

            $grid[$row][$col] = formula($grid[$prev_row][$prev_col]);
        }

        if($row == 0)// move cursor
        {
            $row = $col + 1;
            if(!isset($grid[$row])){ $grid[$row] = array(); }
            $col = 0;
        }
        else
        {
            $row--;
            $col++;
        }
    }

    var_dump($grid[$target_row][$target_col]);
        