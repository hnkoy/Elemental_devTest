<?php
/**
* QUESTION 1
*
* Create a form with a single textarea that will sort words or phrases alphabetically separated by commas.
* Validate that the field is not empty.
* Clean up the string to remove any extra spaces and unnecessary commas
* The result should be shown below the form.
*
* Please make sure your code runs as effectively as it can.
*
* The end result should look like the following:
* apples, cars, tables and chairs, tea and coffee, zebras
*/
?>
<?php
try {
    
    if ( $_SERVER[ 'REQUEST_METHOD' ] == 'POST' ) {

        $to_sort = $_POST[ 'to_sort' ];
        $error = '';
        $result = '';
        if ( empty( $to_sort ) ) {
            $error = 'field is empty';
        }
        
        $to_sort = trim( $to_sort );
        $to_sort = preg_replace('/,+/', ',', $to_sort);
        $to_sort = trim($to_sort, ',');
        $words = explode( ' ', $to_sort );
    
        sort( $words, SORT_NATURAL | SORT_FLAG_CASE );
    
        $words_count = count( $words );
    
        if ( $words_count > 1 ) {
    
            $item = array_pop( $words );
    
            $result = implode( ', ', $words ). ' and ' . $item;
    
        } else {
    
            $result = implode( ', ', $words );
    
        }
    
    }
} catch (\Throwable $th) {
   echo 'error while processing';
}


?>
<!DOCTYPE html>
<html>
<head>
<title>Test1</title>
</head>
<body>
<h1>Sort List</h1>
<form action = "<?php echo $_SERVER['PHP_SELF'];?>" method = 'post'>
<input type = 'hidden' name = 'action' value = 'sort' />
<label for = 'to_sort'>Please enter the words/phrases to be sorted separated by commas:</label><br/>
<textarea name = 'to_sort' style = 'width: 400px; height: 150px;'></textarea><br/>
<?php if ( isset( $error ) ) {
    echo "<p style='color:red'>$error</p>";
}
?>
<?php if ( isset( $result ) ) {
    echo "<p class='error'>$result</p>";
}
?>
<input type = 'submit' value = 'Sort' />
</form>
</body>
</html>