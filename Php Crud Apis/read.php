<?php

include("connection.php");

$query = "SELECT * FROM tbl_std";

$result = mysqli_query($connection,$query);

$my = [];

while($abc =  mysqli_fetch_assoc($result))
{
  $my[] = $abc;
}

print(json_encode($my));

?>