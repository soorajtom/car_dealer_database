<?php
$servername = "localhost";
$username = "root";
$password = "password";
$dbname = "car_dealer";

$conn = new mysqli($servername, $username, $password, $dbname);
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
} 
$phno = $_GET["phno"];
$ema = $_GET["email"];
$queried = false;
$uid = -1;
if($phno && $ema)
{
  $queried = true;
  $sql = "SELECT * FROM customer WHERE contact_number='$phno' AND email='$ema'";
  $result = $conn->query($sql);
  if($result)
  {
    if($result->num_rows)
    {
      $row = $result->fetch_assoc();
      $uid = $row['id'];
    }
  }
  else
  {
    die("The query you made makes no or very little sense.");
  }
}

function translate_status($status)
{
  if($status == "PENDING")
    return "Your order is under process. Please wait.";
  if($status == "INTRANSIT")
    return "Your order is arriving. Please wait.";
  if($status == "READY")
    return "Your order is ready. Please visit the showroom for collection.";
  if($status == "DELIVERED")
    return "Your order was delivered. Thank you for shopping with us.";
  else
    return "Undefined state. Please contact the admin.";
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

    <style type="text/css">
      footer {
  position: absolute;
  bottom: 0;
  width: 100%;
  height: 30px; /* Set the fixed height of the footer here */
  line-height: 10px; /* Vertically center the text there */
  background-color: #f5f5f5;
}
    </style>
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
            <li class="nav-item">
              <a class="nav-link" href="/">Home
                <span class="sr-only">(current)</span>
              </a>
            </li>
            <li class="nav-item active">
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
         <form>
          <div class="form-group">
            <label for="email">Registered phone number:</label>
            <input type="text" name="phno" class="form-control" id="email" value="<?php echo $phno; ?>" required>
          </div>
          <div class="form-group">
            <label for="pwd">Email id:</label>
            <input type="email" name="email" class="form-control" id="pwd" value="<?php echo $ema; ?>" required>
          </div>
          <button type="submit" class="btn btn-primary">Submit</button>
        </form> 
      </div>
      <!-- <h2>Latest deals</h2> -->

      <!-- Page Features -->
      
    </div>
      <!-- /.row -->
      <?php if($queried): ?>
        <div class="row" style="padding-top: 20px;">
          <?php if($uid >= 0): ?>
            <div class="alert alert-primary">
              <?php
                $sql = "SELECT * FROM customer_order WHERE customer_id=$uid";
                $res = $conn->query($sql);
              ?>
              <?php if($res->num_rows): ?>
              <table class="table table-hover">
                  <thead>
                    <tr>
                      <th>Date</th>
                      <th>ETA</th>
                      <th>Status</th>
                    </tr>
                  </thead>
                  <tbody>
                    <?php while($row=$res->fetch_assoc()): ?>
                    <tr>
                      <td><?php echo $row['date']; ?></td>
                      <td><?php echo $row['ETA']; ?></td>
                      <td><?php echo translate_status($row['status']); ?></td>
                    </tr>
                  <?php endwhile; ?>
                  </tbody>
                </table>
              <?php else: ?>
                <div class="alert alert-warning"> You do not have any orders. Visit our nearest showrrom. </div>
              <?php endif; ?>
            </div>
          <?php else: ?>
            <div class="alert alert-danger">The credentials provided does not match any of our records.</div>
          <?php endif; ?>
        </div>
      <?php endif; ?>

    </div>
    <!-- /.container -->

    <!-- Footer -->
    <footer class="py-4 bg-dark">
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
