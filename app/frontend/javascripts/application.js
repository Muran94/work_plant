import ImageFileFieldHandler from './components/ImageFileFieldHandler.js';

document.addEventListener('DOMContentLoaded', () => {
  const imageFileFields = document.querySelectorAll('.c-form__field--image-file');

  imageFileFields.forEach(imageFileField => { new ImageFileFieldHandler(imageFileField) });
});