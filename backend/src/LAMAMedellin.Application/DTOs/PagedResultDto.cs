using System.Collections.Generic;

namespace LAMAMedellin.Application.DTOs
{
    /// <summary>
    /// DTO para respuestas paginadas
    /// </summary>
    /// <typeparam name="T">Tipo de dato en la lista</typeparam>
    public class PagedResultDto<T>
    {
        public List<T> Items { get; set; } = new();
        public int TotalCount { get; set; }
        public int PageNumber { get; set; }
        public int PageSize { get; set; }
        public int TotalPages => (TotalCount + PageSize - 1) / PageSize;
        public bool HasPreviousPage => PageNumber > 1;
        public bool HasNextPage => PageNumber < TotalPages;
    }
}
