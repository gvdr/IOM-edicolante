using LibPQ
using WritePostgres
using IOM_collector
using MakeWebJSON
using HTTP, JSON3
using JobSchedulers, Pipelines


include("../src/connections.jl")
include("../src/daily_run_news.jl")

endpoint_pre_fe = ENV["ENDPOINTPREFE"]

set_scheduler(
    max_cpu = JobSchedulers.SCHEDULER_MAX_CPU,
    max_mem = JobSchedulers.SCHEDULER_MAX_MEM,
    update_second = JobSchedulers.SCHEDULER_UPDATE_SECOND,
    max_job = JobSchedulers.JOB_QUEUE_MAX_LENGTH
)

daily_news_job = Job(
    @task(daily_run_news_dry(endpoint_pre_fe));
    name = "daily_run_news",
    cron = Cron(:daily)
)

hourly_interest_job = Job(
    @task(daily_run_interest_dry(endpoint_pre_fe));
    name = "hourly_run_interest",
    cron = Cron(:hourly)
)


scheduler_start()

submit!(daily_news_job)
submit!(hourly_interest_job)
