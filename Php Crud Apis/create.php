<?php
include("connection.php");
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
$query = "INSERT INTO tbl_std (stdname,stdage,stdcity) VALUES ('$name','$age','$city')";
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