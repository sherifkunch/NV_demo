resource "aws_ecr_repository" "nv-project-ecr" {
  name                 = "nv-project-ecr-repository"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
}
