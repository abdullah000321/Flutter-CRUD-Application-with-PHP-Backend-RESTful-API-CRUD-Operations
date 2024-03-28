<?php
include("connection.php");

if (isset($_POST['id']))
{
    $id = $_POST['id'];
}
if(isset($_POST['name']))
{
    $name = $_POST['name'];
}
if(isset($_POST['age']))
{
    $age = $_POST['age'];
}
if(isset($_POST['city']))
{
    $city = $_POST['city'];
}
$query = "UPDATE tbl_std SET stdname='$name', stdage='$age', stdcity='$city' WHERE id=$id";
$result = mysqli_query($connection,$query);
$array = [];
if($result)
{
    $array["success"] = "true";
}
else
{
    $array["success"] = "false";
}
print(json_encode($array));
?>