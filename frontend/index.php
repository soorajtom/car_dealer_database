<?php
$servername = "localhost";
$username = "root";
$password = "password";
$dbname = "car_dealer";

$conn = new mysqli($servername, $username, $password, $dbname);
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
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
        <a class="navbar-brand" href="#">Dealerkar - Walk in drive out</a>
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
    <div class="container">

      <!-- Jumbotron Header -->
      <header class="jumbotron my-4 jumboimg">
        <!-- <img class="jumboimg" src="/img/jumbol.jpg"> -->
        <div class="card" style="
          display: inline-block; 
          font-size: 3em; 
          background-color: rgba(255,255,255,0.4);
          margin-bottom: 0px;">
          <div class="card-body">A Warm Welcome!</div>
        </div><br>
        <div class="card" style="
          display: inline-block; 
          color: white;
          font-size: 1.3em;
          background-color: rgba(255,255,255,0);
          margin-bottom: 0px;">
          <div class="card-body">
            <p>Best cars in town<br>Affordable price range</p>
            <!-- <a href="#" class="btn btn-primary btn-lg">Call to action!</a> -->
          </div>
        </div>
      </header>

      <!-- <h2>Latest deals</h2> -->

      <!-- Page Features -->
      <div class="row text-center">
        <?php
        $sql = "SELECT * FROM vehicle";
        $result = $conn->query($sql);
        while($row = $result->fetch_assoc()):
         ?>
        <div class="col-lg-3 col-md-6 mb-4">
          <div class="card">
            <img class="card-img-top" src="/img/car.png" alt="">
            <div class="card-body">
              <h4 class="card-title"><?php echo $row['name']; ?></h4>
              <p class="card-text">
                &#8377; <?php echo $row['price']; ?>
                <br><?php echo $row['particulars']; ?>
              </p>
            </div>
            <div class="card-footer">
              <a href="vehicle.php?vid=<?php echo $row['id']; ?>" class="btn btn-primary">More</a>
            </div>
          </div>
        </div>
      <?php endwhile;?>

      </div>
      <!-- /.row -->

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
