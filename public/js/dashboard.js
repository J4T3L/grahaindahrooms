document.addEventListener("DOMContentLoaded", function () {
  const sidebar = document.getElementById('sidebar');
  const toggleBtn = document.getElementById('toggleSidebar');

  // Toggle sidebar saat tombol diklik
  toggleBtn.addEventListener('click', () => {
      sidebar.classList.toggle('active');
  });

  // Menyembunyikan sidebar saat scroll
  window.addEventListener('scroll', () => {
      if (window.scrollY > 50) {
          sidebar.classList.add('collapsed');
      } else {
          sidebar.classList.remove('collapsed');
      }
  });

  // Feather icons (jika menggunakan Feather icons)
  if (typeof feather !== 'undefined') {
      feather.replace();
  }
});
