

### Prerequisites
- [.NET 6 SDK](https://dotnet.microsoft.com/download/dotnet/6.0)

### Installation
1. Clone the repository: `git clone https://github.com/your-username/your-repository.git`
2. Navigate to the project directory: `cd your-repository`

### Configuration
1. Update the connection string in `appsettings.json` to point to your database.
2. Run database migrations: `dotnet ef database update`

### Running the Application
Use the following commands to build and run the application:

  ```bash
  dotnet build
  dotnet run
  ```
The application will be accessible at http://localhost:5000 by default.
### Admin Account
Account: admin@gmail.com
Password: 123
### Usage
Visit the application in your web browser and explore the provided functionality.

Folder Structure
```bash
/YourProject
  ├── /Controllers
  ├── /Models
  ├── /Views
  ├── /Data
  ├── /wwwroot
  ├── /Areas
  ├── appsettings.json
  ├── Startup.cs
  ├── Program.cs
  └── ...
```
- **Controllers:** Contains the controllers responsible for handling user requests.
- **Models:** Houses the data models used in the application.
- **Views:** Stores the Razor views associated with controllers.
- **Data:** Contains database context and migrations.
- **wwwroot:** Holds static files such as CSS, JavaScript, and images.
- **Areas:** If using areas to organize controllers, views, and models.

## Contributing
Feel free to contribute to the project by opening issues or submitting pull requests. Your feedback and enhancements are welcome!

Happy coding! 🚀
