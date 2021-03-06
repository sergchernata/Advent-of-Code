<?php

    //      Name  ( Cost, Damage, Armor )
    $weapons = array(
            "Dagger" => array(8, 4, 0),
            "Shortsword" => array(10, 5, 0),
            "Warhammer" => array(25, 6, 0),
            "Longsword" => array(40, 7, 0),
            "Greataxe" => array(74, 8, 0)
        );

    $armor = array(
            "Leather" => array(13, 0, 1),
            "Chainmail" => array(31, 0, 2),
            "Splintmail" => array(53, 0, 3),
            "Bandedmail" => array(75, 0, 4),
            "Platemail" => array(102, 0, 5)
        );

    $rings = array(
            "Damage +1" => array(25, 1, 0),
            "Damage +2" => array(50, 2, 0),
            "Damage +3" => array(100, 3, 0),
            "Defense +1" => array(20, 0, 1),
            "Defense +2" => array(40, 0, 2),
            "Defense +3" => array(80, 0, 3)
        );

    $everything = array_values(array_merge($weapons, $armor, $rings));

    $boss = array("Hit Points" => 104, "Damage" => 8, "Armor" => 1);
    $hero = array("Hit Points" => 100, "Damage" => 0, "Armor" => 0);
    $gold_spent = false;
    $permutations = gmp_strval(gmp_fact(count($everything)) / gmp_fact((count($everything)) - 3));// 3 types of items

    function permute($items, $perms = array( ))
    {
        if (empty($items))
        { 
            var_dump($perms);
        }
        else
        {
            for ($i = count($items) - 1; $i >= 0; --$i)
            {
                 $newitems = $items;
                 $newperms = $perms;
                 list($foo) = array_splice($newitems, $i, 1);
                 array_unshift($newperms, $foo);
                 permute($newitems, $newperms);
             }
        }
    }

    permute($everything);

    while($boss['Hit Points'] > 0 & $hero['Hit Points'] > 0)
    {
        $damage_to_hero = $boss["Damage"] - $hero["Armor"];
        $damage_to_boss = $hero["Damage"] - $boss["Armor"];

        $boss["Hit Points"] -= $damage_to_boss > 0 ? $damage_to_boss : 1;
        $hero["Hit Points"] -= $damage_to_hero > 0 ? $damage_to_hero : 1;
    }

    // var_dump($hero["Hit Points"]);
    // print "<br/>";
    // var_dump($boss["Hit Points"]);