<?php
$servername = "localhost";
$username = "root";
$password = "password";
$dbname = "car_dealer";

$conn = new mysqli($servername, $username, $password, $dbname);
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
} 
$vid = $_GET["vid"];
$sql = "SELECT * FROM vehicle WHERE id=$vid";
$result = $conn->query($sql);
if($result)
{
  $vdet = $result->fetch_assoc();
  $sql = "SELECT color FROM vehicle_color WHERE id=$vid";
  $colors = $conn->query($sql);
}
else
{
  die("The query you made makes no or very little sense.");
}

?>

<!DOCTYPE html>
<html lang="en">

  <head>

    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>Dealerkar</title>

    <!-- Bootstrap core CSS -->
    <link href="vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">

    <!-- Custom styles for this template -->
    <link href="css/heroic-features.css" rel="stylesheet">
    <link href="css/custom.css" rel="stylesheet">

  </head>

  <body>

    <!-- Navigation -->
    <nav class="navbar navbar-expand-lg navbar-dark bg-dark fixed-top">
      <div class="container">
        <a class="navbar-brand" href="/">Dealerkar - Walk in drive out</a>
        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarResponsive" aria-controls="navbarResponsive" aria-expanded="false" aria-label="Toggle navigation">
          <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarResponsive">
          <ul class="navbar-nav ml-auto">
            <li class="nav-item active">
              <a class="nav-link" href="/">Home
                <span class="sr-only">(current)</span>
              </a>
            </li>
            <li class="nav-item">
              <a class="nav-link" href="check_book.php">Check booking status</a>
            </li>
            <li class="nav-item">
              <a class="nav-link" href="contact.php">Contact</a>
            </li>
            <li class="nav-item">
              <a class="nav-link" href="dbedit.php">Admin Area</a>
            </li>
          </ul>
        </div>
      </div>
    </nav>

    <!-- Page Content -->
    <div class="container" style="padding-top: 20px;">
      <div class="row">
      <div class="col-md-8">
        <!-- <div class="card">
          <div class="card-header" style="font-size: 2em;"><?php echo $vdet['name'] ?></div>
          <img class="card-img-top" src="/img/car.png" alt="">
          <div class="card-body">aasd</div>
          <div class="card-footer">Book now!</div>
        </div> -->
        <h2><?php echo $vdet['name'] ?></h2>
        <img src="/img/car.png" alt="">
      </div>      
      <div class="col-md-4">
        <table class="table table-hover" style="margin-top: 50px;">
            <tbody>
              <tr>
                <th>Max Speed</th>
                <td><?php echo $vdet['max_speed']; ?></td>
              </tr>
              <tr>
                <th>Cylinder vol</th>
                <td><?php echo $vdet['cylinder_vol']; ?></td>
              </tr>
              <tr>
                <th>Mileage</th>
                <td><?php echo $vdet['mileage']; ?></td>
              </tr>
              <tr>
                <th>Transmission</th>
                <td><?php echo $vdet['transmission']; ?></td>
              </tr>
              <tr>
                <th>Price</th>
                <td>&#8377; <?php setlocale(LC_MONETARY,"en_US"); echo money_format("%i", (float)($vdet['price'])); ?></td>
              </tr>
            </tbody>
          </table>
          <div>
            <span style="font-weight: bold">Available in : </span>
              <?php while($colo = $colors->fetch_assoc()): ?>
                <div class="btn" style="background-color: <?php echo $colo['color']; ?> "> <?php echo $colo['color']; ?> </div>
              <?php endwhile; ?>
          </div>
          
      </div>
      <!-- <h2>Latest deals</h2> -->

      <!-- Page Features -->
      
    </div>
      <!-- /.row -->

    <div class="row">

    </div>

    </div>
    <!-- /.container -->

    <!-- Footer -->
    <footer class="py-5 bg-dark">
      <div class="container">
        <p class="m-0 text-center text-white">Copyright &copy; Dealerkar 2018</p>
      </div>
      <!-- /.container -->
    </footer>

    <!-- Bootstrap core JavaScript -->
    <script src="vendor/jquery/jquery.min.js"></script>
    <script src="vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

  </body>

</html>
