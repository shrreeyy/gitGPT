### About gitGPT

GitGPT is an innovative platform that combines the functionality of GitHub and ChatGPT to help automate the process of creating GitHub issues and reviewing pull requests. By leveraging the GitHub REST API and OpenAI REST API, GitGPT can suggest titles and descriptions for issues based on the context provided by the user or project manager. Additionally, team leaders can use GitGPT to automatically add reviews to specific files within a pull request, with ChatGPT providing suggestions for comments. Overall, GitGPT streamlines the process of managing GitHub issues and pull requests, allowing development teams to work more efficiently and productively.

### Setting up your development environment

1. Clone the Repo
2. bundle install
3. Setup database
   bundle exec rake db:create
   bundle exec rake db:schema:load
   bundle exec rake db:migrate

4. Start Rails server - `bundle exec rails s`

# Troubleshooting

## When the Rails server process hangs
How to solve "Address already in use - bind(2) for "127.0.0.1" port 3000" error:

Find PID with `lsof -n -i :3000 | grep LISTEN`, then `kill -9 PID`.

# Contributing

gitGPT is an project and we encourage contributions. [Read the doc](https://docs.google.com/document/d/1sfN3kNbTtDmRPqaPvmjxFS0vNQoaMHQrWJgJ9NZbFl0) to get started.
