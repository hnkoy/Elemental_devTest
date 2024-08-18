


<?php
/**
 * QUESTION 3
 *
 * For each month that had sales show a list of customers ordered by who spent the most to who spent least.
 * If the totals are the same then sort by customer.
 * If a customer has multiple products then order those products alphabetical.
 * Months with no sales should not show up.
 * Show the name of the customer, what products they bought and the total they spent.
 * Only show orders with the "Payment received" and "Dispatched" status.
 * If there are no results, then it should just say "There are no results available."
 *
 * Please make sure your code runs as effectively as it can.
 *
 * See test3.html for desired result.
 */
?>
<?php
//$con holds the connection
require_once('db.php');
?>
<!DOCTYPE html>
<html>
<head>
	<title>Test3</title>
</head>
<body>
<h1>Top Customers per Month</h1>

<?php

$query = "CALL GetOrders();";
$result = $con->query($query);

$current_month = "";
if ($result->num_rows > 0) {
 

    while ($row = $result->fetch_assoc()) {

        if ($current_month != $row['order_month']) {
            if ($current_month != "") {
                echo "</tbody></table>";
            }
            $current_month = $row['order_month'];
            echo "<h2>" . $current_month . "</h2>";
            echo "<table width=\"800\"><tbody>";
            echo "<tr>
                    <th width=\"200\" align=\"left\">Customer</th>
                    <th width=\"400\" align=\"left\">Products Bought</th>
                    <th width=\"200\" align=\"right\">Total</th>
                  </tr>";
        }

        echo "<tr>
                <td valign=\"top\">" . htmlspecialchars($row['customer']) . "</td>
                <td>" . $row['products_bought'] . "</td>
                <td valign=\"bottom\" align=\"right\">R " . number_format($row['total_spent'], 2) . "</td>
              </tr>";
    }

    echo "</tbody></table>";
} else {
   
    echo "<p>There are no results available.</p>";
}

$con->close();
?>




</body>
</html>
