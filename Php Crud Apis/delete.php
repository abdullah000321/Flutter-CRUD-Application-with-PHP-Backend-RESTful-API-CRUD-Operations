<?php
include("connection.php");
if (isset($_POST['id'])) {
    $id = $_POST['id'];
}
$query = "DELETE from tbl_std WHERE id = $id";
$result = mysqli_query($connection,$query);
$arr = [];
if ($result) {
    $arr["success"] = "true";
}
else {
    $arr["success"] = "false";
}
print(json_encode($arr));
?>