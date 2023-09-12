function get_users(endpoint)
    response = HTTP.request(
        "GET",
        "https://$(endpoint)/readers",
        ["Accept-Profile" => "api"]
    )
    response = JSON3.read(response.body)
    userids = [user["userid"] for user in response]
    return userids
end

function get_users_collections(endpoint)
    response = HTTP.request(
        "GET",
        "https://$(endpoint)/readers",
        ["Accept-Profile" => "api"]
    )
    response = JSON3.read(response.body)
    uids_cids = [(user["userid"], user["collectionid"]) for user in response]
    return uids_cids
end

function daily_run_news(endpoint)
    users = get_users(endpoint)
    for userID in users
        deliver_papers(userID)
    end
    return true
end

function deliver_papers(userID)
    collect_day(userID)
    proc = process_todays_articles(userID)
    create_web_JSON(userID,proc)
    println("The user $(userID) got his $(today()) paper on the front door")
end

function daily_run_news_dry(endpoint)
    users = get_users(endpoint)
    for userID in users
        deliver_papers_dry(userID)
    end
    return true
end

function deliver_papers_dry(userID)
    println("The user $(userID) got his $(today()) paper on the front door")
end