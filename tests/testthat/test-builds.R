context("builds")

withr::with_dir(
  "travis-testthat",
  {
    test_that("Querying builds works (.org)", {
      builds <- travis_get_builds(endpoint = ".org")
      expect_s3_class(builds, "travis_builds")
    })

    test_that("Querying builds works (.com)", {
      builds <- travis_get_builds(endpoint = ".com")
      expect_s3_class(builds, "travis_builds")
    })

    test_that("triggering a new build works (.org)", {
      skip_if(!Sys.getenv("TRAVIS_PULL_REQUEST") == "false",
        message = "Skipping on Travis PR builds"
      )

      set.seed(42)
      id <- sample(2:8, 1)

      expect_s3_class(
        travis_restart_build(
          travis_get_builds(endpoint = ".org")[[id]]$id,
          endpoint = ".org",
        ),
        "travis_pending"
      )
    })

    test_that("triggering a new build works (.com)", {
      skip_if(!Sys.getenv("TRAVIS_PULL_REQUEST") == "false",
        message = "Skipping on Travis PR builds"
      )

      set.seed(42)
      id <- sample(2:8, 1)

      expect_s3_class(
        travis_restart_build(
          travis_get_builds(endpoint = ".com")[[id]]$id,
          endpoint = ".com",
        ),
        "travis_pending"
      )
    })

    test_that("cancelling a build works (.org)", {
      skip_if(!Sys.getenv("TRAVIS_PULL_REQUEST") == "false",
        message = "Skipping on Travis PR builds"
      )

      Sys.sleep(5)

      set.seed(42)
      id <- sample(2:8, 1)

      expect_s3_class(
        travis_cancel_build(
          travis_get_builds(endpoint = ".org")[[id]]$id,
          endpoint = ".org",
        ),
        "travis_pending"
      )
    })

    test_that("cancelling a build works (.com)", {
      skip_if(!Sys.getenv("TRAVIS_PULL_REQUEST") == "false",
        message = "Skipping on Travis PR builds"
      )

      Sys.sleep(5)

      set.seed(42)
      id <- sample(2:8, 1)

      expect_s3_class(
        travis_cancel_build(
          travis_get_builds(endpoint = ".com")[[id]]$id,
          endpoint = ".com",
        ),
        "travis_pending"
      )
    })

    test_that("Querying jobs works (.org)", {
      builds <- travis_get_jobs(
        travis_get_builds(
          endpoint = ".org"
        )[[1]]$id,
        endpoint = ".org"
      )
      expect_s3_class(builds, "travis_jobs")
    })

    test_that("Querying jobs works (.com)", {
      builds <- travis_get_jobs(
        travis_get_builds(
          endpoint = ".com"
        )[[1]]$id,
        endpoint = ".com"
      )
      expect_s3_class(builds, "travis_jobs")
    })

    test_that("restarting a job works (.org)", {
      skip_if(!Sys.getenv("TRAVIS_PULL_REQUEST") == "false",
        message = "Skipping on Travis PR builds"
      )

      Sys.sleep(0.5)

      set.seed(42)
      id <- sample(9:16, 1)

      expect_s3_class(
        travis_restart_job(
          travis_get_jobs(
            travis_get_builds(endpoint = ".org")[[id]]$id,
            endpoint = ".org"
          )[[1]]$id,
          endpoint = ".org"
        ),
        "travis_pending"
      )
    })

    test_that("restarting a job works (.com)", {
      skip_if(!Sys.getenv("TRAVIS_PULL_REQUEST") == "false",
        message = "Skipping on Travis PR builds"
      )

      Sys.sleep(0.5)

      set.seed(42)
      id <- sample(9:16, 1)

      expect_s3_class(
        travis_restart_job(
          travis_get_jobs(
            travis_get_builds(endpoint = ".com")[[id]]$id,
            endpoint = ".com"
          )[[1]]$id,
          endpoint = ".com"
        ),
        "travis_pending"
      )
    })

    test_that("cancelling a job works (.org)", {
      skip_if(!Sys.getenv("TRAVIS_PULL_REQUEST") == "false",
        message = "Skipping on Travis PR builds"
      )

      Sys.sleep(5)

      set.seed(42)
      id <- sample(9:16, 1)

      expect_s3_class(
        travis_cancel_job(
          travis_get_jobs(
            travis_get_builds(endpoint = ".org")[[id]]$id,
            endpoint = ".org"
          )[[1]]$id,
          endpoint = ".org"
        ),
        "travis_pending"
      )
    })

    test_that("cancelling a job works (.com)", {
      skip_if(!Sys.getenv("TRAVIS_PULL_REQUEST") == "false",
        message = "Skipping on Travis PR builds"
      )

      Sys.sleep(5)

      set.seed(42)
      id <- sample(9:16, 1)

      expect_s3_class(
        travis_cancel_job(
          travis_get_jobs(
            travis_get_builds(endpoint = ".com")[[id]]$id,
            endpoint = ".com"
          )[[1]]$id,
          endpoint = ".com"
        ),
        "travis_pending"
      )
    })

    test_that("restarting a debug job works (.org)", {
      skip_if(!Sys.getenv("TRAVIS_PULL_REQUEST") == "false",
        message = "Skipping on Travis PR builds"
      )

      set.seed(42)
      id <- sample(16:24, 1)

      expect_s3_class(
        travis_debug_job(
          travis_get_jobs(
            travis_get_builds(repo = "mlr-org/mlr", endpoint = ".org")[[id]]$id,
            endpoint = ".org"
          )[[1]]$id,
          endpoint = ".org", repo = "mlr-org/mlr"
        ),
        "travis_pending"
      )
    })

    test_that("restarting a debug job works (.com)", {
      skip_if(!Sys.getenv("TRAVIS_PULL_REQUEST") == "false",
        message = "Skipping on Travis PR builds"
      )

      set.seed(42)
      id <- sample(16:24, 1)

      expect_s3_class(
        travis_debug_job(
          travis_get_jobs(
            travis_get_builds(
              repo = "ropenscilabs/tic",
              endpoint = ".com"
            )[[id]]$id,
            endpoint = ".com"
          )[[1]]$id,
          endpoint = ".com", repo = "ropenscilabs/tic"
        ),
        "travis_pending"
      )
    })

    # we need to cancel to be able to start again during covr
    test_that("cancelling a debug job works (.org)", {
      skip_if(!Sys.getenv("TRAVIS_PULL_REQUEST") == "false",
        message = "Skipping on Travis PR builds"
      )

      Sys.sleep(5)

      set.seed(42)
      id <- sample(16:24, 1)

      expect_s3_class(
        travis_cancel_job(
          travis_get_jobs(
            travis_get_builds(repo = "mlr-org/mlr", endpoint = ".org")[[id]]$id,
            endpoint = ".org"
          )[[1]]$id,
          endpoint = ".org", repo = "mlr-org/mlr"
        ),
        "travis_pending"
      )
    })

    # we need to cancel to be able to start again during covr
    test_that("cancelling a debug job works (.com)", {
      skip_if(!Sys.getenv("TRAVIS_PULL_REQUEST") == "false",
        message = "Skipping on Travis PR builds"
      )

      Sys.sleep(5)

      set.seed(42)
      id <- sample(16:24, 1)

      expect_s3_class(
        travis_cancel_job(
          travis_get_jobs(
            travis_get_builds(
              repo = "ropenscilabs/tic",
              endpoint = ".com"
            )[[id]]$id,
            endpoint = ".com"
          )[[1]]$id,
          endpoint = ".com", repo = "ropenscilabs/tic"
        ),
        "travis_pending"
      )
    })

    test_that("retrieving logs works (.org)", {
      expect_s3_class(
        travis_get_log(
          travis_get_jobs(
            travis_get_builds(endpoint = ".org")[[17]]$id,
            endpoint = ".org"
          )[[1]]$id,
          endpoint = ".org"
        ),
        "character"
      )
    })

    test_that("retrieving logs works (.com)", {
      expect_s3_class(
        travis_get_log(
          travis_get_jobs(
            travis_get_builds(endpoint = ".com")[[17]]$id,
            endpoint = ".com"
          )[[1]]$id,
          endpoint = ".com"
        ),
        "character"
      )
    })

    test_that("deleting logs works (.org)", {
      skip(message = "We do not have enough logs to delete one at every build")

      expect_s3_class(
        travis_delete_log(
          travis_get_jobs(
            travis_get_builds(endpoint = ".org")[[5]]$id,
            endpoint = ".org"
          )[[3]]$id,
          endpoint = ".org"
        ),
        "character"
      )
    })

    test_that("deleting logs works (.com)", {
      skip(message = "We do not have enough logs to delete one at every build")

      expect_s3_class(
        travis_delete_log(
          travis_get_jobs(
            travis_get_builds(endpoint = ".com")[[5]]$id,
            endpoint = ".com"
          )[[3]]$id,
          endpoint = ".com"
        ),
        "character"
      )
    })
  }
)
