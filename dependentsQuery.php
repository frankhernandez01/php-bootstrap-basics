<?PHP
#initialized vars performing ternary operator to grab the values from the post request or set to empty string
$inpdname = isset($_POST['inpdname']) ? $_POST['inpdname'] : '';
$visited = isset($_POST['visited']) ? $_POST['visited'] : '';
$inpdnamemsg = '';
?>
<html lang="en">
  <head>
    <!-- Required meta tags -->
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <!-- Bootstrap CSS (adds styling for neat responsive presentation)Using CDN to minimize file dependecies -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" 
          integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm"
          crossorigin="anonymous">
    <title>Frank ASG-3
    </title>
    <!--in line styles are bad practice making exception to minimize external files-->
    <style>
      .margined {
        margin-top: 2%;
      }
    </style>
  </head>
  <body>
    <div class="container">
      <div class="margined">
        <h2 class="text-center">Dependents Query
        </h2>
        <div class="row">
          <div class="col-sm-12 col-lg-8 mx-auto">
            <br>
            <p> 
              <strong>Input:
              </strong> Dependent name in form field then hit submit
            </p>
            <p> 
              <strong>Desired Output:
              </strong>
            </p> 
            <ul>
              <li>dependent name</li>
              <li>firstname, lastname of the corresponding employee</li>
              <li>firstname, lastname of the manager for that employee</li>
              <li><strong>OR</strong> Appropiate error messages i.e: Invalid dependent name Tim 
              </li>
            </ul>
            <?php
                if (!($inpdname )) {
                    if ($visited) {	  
                    $inpdnamemsg = 'Please enter a dependent name';
                    }
                    #print the bootstrap styled form 
                    echo '
                    <!--Setting the form to send a POST request with the input passed in the request this will form url encoded -->

                    <h3 class="text-center">Form</h3>
                    <form method="POST" action="'. $_SERVER['PHP_SELF'] .'">
                    <div class="form-group">
                    <label for="dependentName">Dependent Name</label>

                    <!-- set the input to use the var names set up top hidden field to set the visit var -->

                    <input class="form-control" name="inpdname"  placeholder="Enter name i.e Joy">
                    <input type="hidden" name="visited" value="true">

                    <!--small message helping the user-->
                    <small id="emailHelp" class="form-text text-muted" style="color:red !important">'.$inpdnamemsg.'</small>
                    <INPUT type="hidden" name="visited" value="true">
                    </div>
                    <button type="submit" class="btn btn-primary">Submit</button>
                    </form>';
                }
                else{
                    require ('./dbConfig.php');
                    $querystring="
                    SELECT dependent_name AS Dependent, emp_1.fname, 
                    emp_1.lname,emp_2.fname AS MGR_FName, emp_2.lname AS MGR_LName
                    FROM  dependent,employee AS emp_1, employee AS emp_2
                    WHERE dependent_name='$inpdname' AND essn=emp_1.ssn AND 
                    emp_2.ssn=emp_1.superssn";
                                        
                    $result = mysqli_query($con, $querystring);
                    if (!$result) {
                      print ( "Could not successfully run query ($querystring) from DB: " . mysqli_error($con) . "<br>");
                      exit;
                    }
                  
                    if (mysqli_num_rows($result) == 0) {
                      print ("No rows found, nothing to print so am exiting<br>");
                      exit;
                    }
                  
                  // Print the column names as the headers of a table
                  echo '<table border="1|0"><tr>';
                  for($i = 0; $i < mysqli_num_fields($result); $i++) {
                      $field_info = mysqli_fetch_field($result);
                      echo "<th>{$field_info->name}</th>";
                  }

                  // Print the data
                  while($row = mysqli_fetch_row($result)) {
                      echo "<tr>";
                      foreach($row as $_column) {
                          echo "<td>  {$_column}  </td>";
                      }
                      echo "</tr>";
                  }

                  echo "</table>";
                    mysqli_close($con);
                }
            ?>
          </div>
        </div>
      </div>
    </div>
  </body>
</html>
