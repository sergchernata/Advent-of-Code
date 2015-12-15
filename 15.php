<?php        
        $input = "Sprinkles: capacity 2, durability 0, flavor -2, texture 0, calories 3
Butterscotch: capacity 0, durability 5, flavor -3, texture 0, calories 3
Chocolate: capacity 0, durability 0, flavor 5, texture -1, calories 8
Candy: capacity 0, durability -1, flavor 0, texture 5, calories 8";

        $ingredients = explode("\n", $input);
        $max_spoons = 100;
        $highest_score = 0;

        function formula($first, $second, $third, $fourth)
        {
            $capacity = max(($first * 2) + ($second * 0) + ($third * -2) + ($fourth * 0), 0);
            $durability = max(($first * 0) + ($second * 5) + ($third * -3) + ($fourth * 0), 0);
            $flavor = max(($first * 0) + ($second * 0) + ($third * 5) + ($fourth * -1), 0);
            $texture = max(($first * 0) + ($second * -1) + ($third * 0) + ($fourth * 5), 0);

            return $capacity * $durability * $flavor * $texture;
        }

        for ($f=0; $f < $max_spoons; $f++)
        {
            for ($s=0; $s < $max_spoons - $f; $s++)
            {
                for ($t=0; $t < $max_spoons - ($f + $s); $t++)
                {
                    $o = $max_spoons - ($t + $f + $s);

                    $total = formula($f, $s, $t, $o);

                    if($total > $highest_score)
                    {
                        $highest_score = $total;
                    }
                }
            }
        }

        var_dump($highest_score);