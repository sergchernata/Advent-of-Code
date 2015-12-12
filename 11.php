<?php        
        function has_increasing_straight($string, $allowed)
        {
            for ($i=0; $i < strlen($string) - 2; $i++)
            {
                if(strpos($allowed, substr($string, $i, 3)) !== false){ return true; }
            }

            return false;
        }

        function has_two_pairs($string)
        {
            $num_pairs = 0;
            $chars = str_split($string);

            for ($i=0; $i < count($chars); $i++)
            {
                if(isset($chars[$i + 1]) && $chars[$i] === $chars[$i + 1])
                {
                    $num_pairs++;
                    $i++;
                }
            }

            if($num_pairs >= 2){ return true; }else{ return false; }
        }

        function cascade($chars, $allowed)
        {
            $new = $chars;
            
            for ($i = count($chars) - 1; $i >= 0; $i--)
            {
                if($chars[$i] === 'z')
                {
                    $new[$i] = 'a';
                    $next = array_search($chars[$i - 1], $allowed) + 1;
                    $next = $next > count($allowed) - 1 ? 0 : $next;
                    $new[$i - 1] = $allowed[$next];
                }
            }

            return $new;
        }

        $input = 'hxbxxyzz';
        $input_chars = str_split($input);
        $input_len = count($input_chars) - 1;
        $allowed = "abcdefghjkmnpqrstuvwxyz";
        $allowed_chars = str_split("abcdefghjkmnpqrstuvwxyz");
        
        $i = $input_len;

        do
        {
            $current_pos = array_search($input_chars[$i], $allowed_chars);

            if($current_pos === count($allowed_chars) - 1)// end of allowed chars, increment and start over
            {
                $input_chars = cascade($input_chars, $allowed_chars);
            }
            else// keep rolling
            {
                $input_chars[$i] = $allowed_chars[++$current_pos];
            }
        }
        while(!has_increasing_straight(implode($input_chars), $allowed) || !has_two_pairs(implode($input_chars)));

        var_dump(implode($input_chars));