# FaceRekognition-Demo

This is a tiny demo application which demonstrates the Amazon AWS 'Rekognition' face and image recognition API, as well as the 'Polly' speech synthesis API.

It uses the JPEG Camera library to take a photo from your PC/device onboard camera and send the facial data to Amazon for comparison and identification.

Full blog post about this project is here: http://devan.blaze.com.au/blog/2017/3/13/building-a-face-recognition-app-in-less-than-an-hour

## Prerequisites

You will need Ruby installed on your development machine *(Note: NOT Ruby on Rails, just plain Ruby language)*.  This app uses the light weight Sinatra framework to do all the back end heavy lifting.

Before running this web app, you will need to set up a .env file in the project folder with your Amazon IAM key and secret (as per the blog post above).

```
export AWS_KEY=<your IAM key here>
export AWS_SECRET=<your IAM secret here>
```

If you are using Linux/OS X, then you can just run the above commands in your terminal or shell to set up the environment variables.  Windows users can type the following two lines into their DOS prompt:

```
export AWS_KEY=<your IAM key here>
export AWS_SECRET=<your IAM secret here>
```

Once that is done, you can install all dependencies by typing:

```
bundle install
```

Then run the web app by typing:

```
ruby faceapp.rb
```

This will start a local web server, listening on port 4567.  Then it is a matter of visiting the following URL in your web browser:

```
http://localhost:4567
```

Feel free to fork and improve this simple demo.  Any issues, contact me via Twitter @dsabar

