# Catalogue
The cat-alogue app displays a list of cat breeds with detailed information about them. You can even keep track of your favorites.

| Splash screen | Catalogue | Detail View | Search |
| --- | --- | --- | --- |
| <img src="https://github.com/user-attachments/assets/ed2ff865-3644-448b-8e1c-217b9db49ead" /> | <img src="https://github.com/user-attachments/assets/86e4f166-abf7-4517-b239-f8a6aebd376f" /> | <img src="https://github.com/user-attachments/assets/4f748754-e8d1-465b-a712-c5d80a7a7c09" /> | <img src="https://github.com/user-attachments/assets/5347b024-abd3-4c07-9de8-2982081298d8" /> |


## Get Started
Catalogue is designed to work with an API key from [The Cat API](https://thecatapi.com). You will need to get a free API key after [creating an account](https://thecatapi.com/signup). Follow these instructions:

1. Get the API key.
2. Insert into your Xcode schema by clicking the target icon at the top > "Edit Schema" > Within "Run", select "Arguments", and add your environment key value to an environment name of "API_Secret_Key".
3. Ensure you have signing capabilities enabled under the Project settings for the "Catalogue" target.
4. Run the app and enjoy cataloguing your favorite cats!

## Architecture 
Catalogue is implemented using MVVM architecture pattern. The Model has all necessary data and business logic needed to retrieve the cat breeds from the web service. The view is responsible for displaying the cat breeds to the user. The ViewModel stores and manages the retrieved data.
