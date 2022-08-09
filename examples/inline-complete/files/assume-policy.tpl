{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "AWS": [
          "arn:aws:iam::${account_id}:role/${role_name}"
        ]
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
