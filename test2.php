<?php
/**
* QUESTION 2
*
* Using the data stored in the database
* show a list of products with their prices
* grouped by category.
* The categories should be listed in alphabetical order.
* The products within those categories should also be listed in alphabetical order.
* Products with no category will be categorized as 'Uncategorized'.
* If there are no results, then it should just say 'There are no results available.'
*
* Please make sure your code runs as effectively as it can.
*
* See test2.html for desired result.
*/
?>
<?php
//$con holds the connection
require_once( 'db.php' );
try {
    $products = [];
    $result = $con->query( 'CALL GetProducts();' );

    if ( mysqli_num_rows( $result ) > 0 ) {
        while ( $row = mysqli_fetch_assoc( $result ) ) {
            $products[ $row[ 'category_name' ] ][] = $row;
        }

    } else {
        echo '<h1>Products</h1>';
        echo '<p>There are no results available.</p>';
    }
    mysqli_close( $con );
} catch ( mysqli_sql_exception $th ) {
    echo 'db connection or query failed';
}catch (\Throwable $th) {
    echo 'error while processing';
}


?>
<!DOCTYPE html>
<html>
<head>
<title>Test2</title>
</head>
<body>
<h1>Products</h1>

<?php

foreach ( $products as $category => $items ) {
    echo '<h2>' . htmlspecialchars( $category ) . '</h2>';
    echo '<table width="400">';
    echo '<tr><th align="left">Product</th><th align="right">Price</th></tr>';

    foreach ( $items as $item ) {
        echo '<tr>';
        echo '<td>' . htmlspecialchars( $item[ 'product' ] ) . '</td>';
        echo '<td align="right">R ' . number_format( $item[ 'price' ], 2 ) . '</td>';
        echo '</tr>';
    }

    echo '</tbody></table>';
}

?>

</body>
</html>