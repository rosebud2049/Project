defmodule Project01.SwaggerContexts.SwaggerContext do
    use PhoenixSwagger
    
    def swagger_definitions do
        %{
            Users: swagger_schema do
                title "Users"
                description "Collection of users available for using Time Manager"
                properties do
                    username :string
                    email :string
                    id :integer
                    password :string
                    role :string
                end
            end,

            WorkingTimes: swagger_schema do
                title "WorkingTimes"
                description "Collection of working times for each users"
                properties do
                    start :datetime
                    ending :datetime
                    user_id :integer
                    items Schema.ref(:Users)
                end
            end,

            Link: swagger_schema do
                title "Link"
                description "Collection of link between users and their teams"
                properties do
                    user_id :integer
                    team_id :integer
                end
            end,

            Teams: swagger_schema do
                title "Teams"
                description "Collection of teams"
                properties do
                    name :string
                end
            end
        }
    end
end