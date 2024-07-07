# Rogram - iOS Coding Challenge

## Overview

Rogram is a native iOS application that allows users to browse photos from an API. This app focuses specifically on getting photos from the api and showing in a tableview. Users can also click on the photo and view in full screen.

## API Endpoints

The application utilizes the following API endpoint:

1. **Get Photos**
   - URL: `https://jsonplaceholder.typicode.com/album/1/photos`
   - Purpose: To fetch the list of photos.

## Project Structure

The project is organized into several folders to maintain a clean and scalable architecture using the MVVM (Model-View-ViewModel) pattern.

- **Services**
  - NetworkService: Manages network requests to fetch data stream.

- **Home**
  - Controller: Manages the UI components, such as views.
  - ViewModel: Manages data for the views and interacts with the business logic.
  - UseCases:
    - GetPhotosUseCase: Handles the business logic for fetching and parsing photos from the server.
  - Model: Contains data model representing the JSON objects.
 
- **PhotoDetail**
  - Controller: Manages the UI components, such as views.
  - Model: Contains data model representing the JSON objects.
 
